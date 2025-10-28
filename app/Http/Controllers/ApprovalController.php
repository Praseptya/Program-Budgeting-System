<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Notifications\BudgetStatusNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;                     // ⬅ pakai model, bukan DB::table utk notifikasi

class ApprovalController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $budgets = DB::table('budgets as b')
            ->leftJoin('users as u', 'u.id_user', '=', 'b.created_by')
            ->leftJoin('budget_items as bi', 'bi.budget_id', '=', 'b.id_budget')
            ->select(
                'b.id_budget',
                'b.budget_name',
                'u.name as created_by',
                'b.periode_from',
                'b.periode_to',
                'b.status',
                DB::raw('COALESCE(SUM(bi.amount), 0) as total')
            )
            ->groupBy('b.id_budget', 'b.budget_name', 'u.name', 'b.periode_from', 'b.periode_to', 'b.status')
            ->orderBy('b.created_at', 'desc')
            ->get();

        return view('approval.index', compact('budgets'));
    }

    public function approve($id)
    {
        $budget = DB::table('budgets')->where('id_budget', $id)->first();
        if (! $budget) {
            return back()->with('error', 'Budget tidak ditemukan.');
        }

        DB::table('budgets')
            ->where('id_budget', $id)
            ->update([
                'status' => 'Approved',
                'updated_at' => now(),
            ]);

        // kirim notifikasi ke PEMBUAT budget sebagai model User (punya Notifiable)
        $creator = User::where('id_user', $budget->created_by)->first();
        if ($creator) {
            try {
                // kirim langsung (sync). Jika queue aktif, pastikan tabel jobs ada.
                $creator->notify(new BudgetStatusNotification($budget, 'Approved'));
            } catch (\Throwable $e) {
                Log::warning('Gagal kirim notifikasi approve: '.$e->getMessage());
            }
        }

        return back()->with('success', 'Budget berhasil disetujui.');
    }

    public function reject(Request $request, $id)
    {
        $request->validate([
            'reason' => 'required|string|max:500',
        ]);

        $budget = DB::table('budgets')->where('id_budget', $id)->first();
        if (! $budget) {
            return back()->with('error', 'Budget tidak ditemukan.');
        }

        $reason = $request->input('reason');

        DB::table('budgets')
            ->where('id_budget', $id)
            ->update([
                'status' => 'Rejected',
                'rejection_reason' => $reason,
                'updated_at' => now(),
            ]);

        $creator = User::where('id_user', $budget->created_by)->first();
        if ($creator) {
            try {
                $creator->notify(new BudgetStatusNotification($budget, 'Rejected', $reason));
            } catch (\Throwable $e) {
                Log::warning('Gagal kirim notifikasi reject: '.$e->getMessage());
            }
        }

        return back()->with('error', 'Budget ditolak.');
    }
}
