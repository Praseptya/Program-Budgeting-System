{{-- resources/views/account/password.blade.php --}}
@extends('layouts.app')

@section('title','Ganti Password')
@section('page_title','Ganti Password')

@push('styles')
<link rel="stylesheet" href="{{ asset('css/master-data.css') }}">
<link rel="stylesheet" href="{{ asset('css/password.css') }}">
@endpush

@section('content')
  {{-- Flash --}}
  @if(session('success'))
    <div class="flash success">{{ session('success') }}</div>
  @endif
  @if(session('error'))
    <div class="flash error">{{ session('error') }}</div>
  @endif
  @if(session('warn'))
    <div class="flash warn">{{ session('warn') }}</div>
  @endif

  {{-- (Opsional) tampilkan OTP saat dev/local --}}
  @if(app()->environment('local') && !empty($devOtp ?? null))
    <div class="flash warn">OTP (dev): <b>{{ $devOtp }}</b></div>
  @endif

  @php
    $email = $user->email ?? auth()->user()->email ?? '';
    $otpSent = $otpSent ?? session('otp_sent', false);
    $resendAt = $resendAt ?? session('otp_resend_at'); // timestamp string atau null
  @endphp

  <div class="pw-card">
    {{-- STEP 1: kirim / kirim ulang OTP --}}
    <form method="POST" action="{{ route('account.password.send') }}" class="pw-inline" style="margin-bottom: 14px;">
      @csrf
      <div style="flex:1;">
        <label class="lbl">Email</label>
        <input class="inp" type="email" value="{{ $email }}" readonly>
      </div>

      @php
        $cooldownLeft = $resendAt ? \Carbon\Carbon::parse($resendAt)->diffInSeconds(now(), false) : 0;
        $isCooling = $resendAt && now()->lt(\Carbon\Carbon::parse($resendAt));
      @endphp

      <div class="row-gap" style="margin-top: 22px;">
        <button class="btn-outline" type="submit" id="btnSendOtp" {{ $isCooling ? 'disabled' : '' }}>
          {{ $otpSent ? 'Kirim Ulang OTP' : 'Kirim OTP' }}
        </button>
        <span class="pw-muted" id="resendTimer" data-left="{{ $isCooling ? \Carbon\Carbon::parse($resendAt)->diffInSeconds(now()) : 0 }}">
          @if($isCooling)
            Bisa kirim ulang dalam <span id="secLeft">{{ \Carbon\Carbon::parse($resendAt)->diffInSeconds(now()) }}</span> dtk
          @else
            Kode akan dikirim ke email Anda.
          @endif
        </span>
      </div>
    </form>

    {{-- STEP 2: verifikasi OTP + ubah password --}}
    @if ($otpSent)
      <form method="POST" action="{{ route('account.password.verify') }}">
        @csrf
        {{-- OTP --}}
        <div>
          <label class="lbl">Kode OTP</label>
          <div class="otp-wrap" style="margin-bottom: 8px;">
            @for($i=0;$i<6;$i++)
              <input class="otp-digit" inputmode="numeric" pattern="[0-9]*" maxlength="1" autocomplete="one-time-code" />
            @endfor
          </div>
          {{-- hidden real value untuk server --}}
          <input type="hidden" name="otp" id="otpHidden">
          @error('otp')
            <div class="flash error" style="margin-top:6px">{{ $message }}</div>
          @enderror
          <div class="note">Masukkan 6 digit kode yang dikirim ke email Anda.</div>
        </div>

        {{-- Password --}}
        <div class="pw-row" style="margin-top:14px;">
          <div>
            <label class="lbl">Password Baru</label>
            <div class="pw-inline" style="gap:8px;">
              <input class="inp" type="password" name="password" id="pw1" placeholder="Minimal 8 karakter">
              <button class="btn-eye" type="button" data-toggle="#pw1"><i class="fa-regular fa-eye"></i></button>
            </div>
            @error('password')
              <div class="flash error" style="margin-top:6px">{{ $message }}</div>
            @enderror
          </div>
          <div>
            <label class="lbl">Konfirmasi Password</label>
            <div class="pw-inline" style="gap:8px;">
              <input class="inp" type="password" name="password_confirmation" id="pw2" placeholder="Ulangi password baru">
              <button class="btn-eye" type="button" data-toggle="#pw2"><i class="fa-regular fa-eye"></i></button>
            </div>
          </div>
        </div>

        <div class="row-gap" style="margin-top:16px;">
          <button class="btn-primary" type="submit">Simpan Password Baru</button>
        </div>
      </form>
    @else
      <div class="note">Klik <b>Kirim OTP</b> untuk menerima kode verifikasi di email Anda.</div>
    @endif
  </div>
@endsection

@push('scripts')
<script>
(function(){
  // ===== Countdown kirim ulang =====
  const timerEl = document.getElementById('resendTimer');
  const btnSend = document.getElementById('btnSendOtp');
  if (timerEl && btnSend) {
    let left = parseInt(timerEl.dataset.left || '0', 10);
    if (left > 0) {
      const secSpan = document.getElementById('secLeft');
      const t = setInterval(()=>{
        left--;
        if (secSpan) secSpan.textContent = String(left);
        if (left <= 0) {
          clearInterval(t);
          btnSend.disabled = false;
          timerEl.textContent = 'Anda bisa mengirim ulang kode sekarang.';
        }
      },1000);
    }
  }

  // ===== OTP 6 kotak → gabung ke hidden field =====
  const boxes = Array.from(document.querySelectorAll('.otp-digit'));
  const hidden = document.getElementById('otpHidden');
  function writeHidden() {
    if (!hidden) return;
    hidden.value = boxes.map(b => (b.value || '').replace(/\D/g,'')).join('').slice(0,6);
  }
  boxes.forEach((box, idx) => {
    box.addEventListener('input', e => {
      const v = box.value.replace(/\D/g,'');
      box.value = v.slice(-1);
      // auto move next
      if (box.value && idx < boxes.length - 1) boxes[idx+1].focus();
      writeHidden();
    });
    box.addEventListener('keydown', e => {
      if (e.key === 'Backspace' && !box.value && idx > 0) {
        boxes[idx-1].focus();
      }
    });
    box.addEventListener('paste', e => {
      e.preventDefault();
      const pasted = (e.clipboardData || window.clipboardData).getData('text').replace(/\D/g,'').slice(0,6);
      for (let i=0;i<boxes.length;i++) boxes[i].value = pasted[i] || '';
      writeHidden();
      const nextIdx = Math.min(pasted.length, boxes.length-1);
      boxes[nextIdx].focus();
    });
  });

  // Pastikan hidden OTP terisi saat submit
  document.querySelectorAll('form').forEach(f => {
    f.addEventListener('submit', () => writeHidden());
  });

  // ===== Toggle show password =====
  document.querySelectorAll('.btn-eye').forEach(btn => {
    btn.addEventListener('click', () => {
      const sel = btn.getAttribute('data-toggle');
      const el = sel ? document.querySelector(sel) : null;
      if (!el) return;
      el.type = (el.type === 'password') ? 'text' : 'password';
    });
  });
})();
</script>
@endpush
