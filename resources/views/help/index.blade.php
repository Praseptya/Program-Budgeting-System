@extends('layouts.app')

@section('title','Help Center')
@section('page_title','Help Center')

@push('styles')
  <link rel="stylesheet" href="{{ asset('css/master-data.css') }}">
  <link rel="stylesheet" href="{{ asset('css/help-center.css') }}">
@endpush

@section('content')
  {{-- Flash (opsional) --}}
  @if(session('success') || session('error'))
    <div class="flash-wrap">
      @if(session('success'))
        <div class="flash success">{{ session('success') }}</div>
      @endif
      @if(session('error'))
        <div class="flash error">{{ session('error') }}</div>
      @endif
    </div>
  @endif

  {{-- Grid 2 kolom: kiri = password + kontak, kanan = panduan + tautan cepat --}}
  {{-- ====== GRID 2x2 ====== --}}
<div class="hc-grid">
  {{-- Password (kiri atas) --}}
  <button type="button" class="hc-tile" data-modal="#mdPassword" aria-haspopup="dialog" aria-controls="mdPassword">
    <div class="hc-ico">
      <i class="fa-solid fa-lock"></i>
    </div>
    <div class="hc-texts">
      <div class="hc-title">Password</div>
      <div class="hc-sub">Ubah sandi via OTP</div>
    </div>
    <i class="fa-solid fa-chevron-right hc-chevron"></i>
  </button>

  {{-- Kontak Bantuan (kanan atas) --}}
  <button type="button" class="hc-tile" data-modal="#mdContact" aria-haspopup="dialog" aria-controls="mdContact">
    <div class="hc-ico hc-ico-green">
      <i class="fa-solid fa-headset"></i>
    </div>
    <div class="hc-texts">
      <div class="hc-title">Kontak Bantuan</div>
      <div class="hc-sub">Email IT & nomor ekstensi</div>
    </div>
    <i class="fa-solid fa-chevron-right hc-chevron"></i>
  </button>

  {{-- Panduan Lengkap (kiri bawah) --}}
  <button type="button" class="hc-tile" data-modal="#mdGuide" aria-haspopup="dialog" aria-controls="mdGuide">
    <div class="hc-ico hc-ico-green">
      <i class="fa-solid fa-book-open"></i>
    </div>
    <div class="hc-texts">
      <div class="hc-title">Panduan Lengkap</div>
      <div class="hc-sub">Langkah penggunaan dari A–Z</div>
    </div>
    <i class="fa-solid fa-chevron-right hc-chevron"></i>
  </button>

  {{-- FAQ (kanan bawah) --}}
  <button type="button" class="hc-tile" data-modal="#mdFaq" aria-haspopup="dialog" aria-controls="mdFaq">
    <div class="hc-ico hc-ico-indigo">
      <i class="fa-solid fa-circle-question"></i>
    </div>
    <div class="hc-texts">
      <div class="hc-title">FAQ</div>
      <div class="hc-sub">Pertanyaan yang sering muncul</div>
    </div>
    <i class="fa-solid fa-chevron-right hc-chevron"></i>
  </button>
</div>

{{-- ====== MODAL: Password ====== --}}
<div id="mdPassword" class="hc-modal" role="dialog" aria-modal="true" aria-labelledby="mdPasswordTitle" hidden>
  <div class="hc-panel">
    <div class="hc-panel-head">
      <h3 id="mdPasswordTitle">Ganti Password</h3>
      <button class="hc-close" data-close>×</button>
    </div>
    <div class="hc-panel-body">
      <p>Ganti password dilakukan melalui verifikasi OTP yang dikirim ke email akun Anda.</p>
      <ol class="hc-steps">
        <li>Buka halaman <b>Ganti Password</b>.</li>
        <li>Klik <b>Kirim OTP</b> dan cek email Anda.</li>
        <li>Masukkan OTP, password baru, lalu simpan.</li>
      </ol>
    </div>
    <div class="hc-panel-foot">
      <a href="{{ route('account.password') }}" class="btn-primary">Buka Halaman Ganti Password</a>
      <button class="btn-outline" data-close>Tutup</button>
    </div>
  </div>
</div>

{{-- ====== MODAL: Kontak ====== --}}
<div id="mdContact" class="hc-modal" role="dialog" aria-modal="true" aria-labelledby="mdContactTitle" hidden>
  <div class="hc-panel">
    <div class="hc-panel-head">
      <h3 id="mdContactTitle">Kontak Bantuan</h3>
      <button class="hc-close" data-close>×</button>
    </div>
    <div class="hc-panel-body">
      <ul class="hc-bullets">
        <li><i class="fa-solid fa-envelope"></i> it-support@metrotv.com</li>
        <li><i class="fa-solid fa-phone"></i> +6221 5830 0077</li>
        <li><i class="fa-solid fa-clock"></i> Senin–Jumat, 09.00–17.00 WIB</li>
      </ul>
    </div>
    <div class="hc-panel-foot">
      <a href="mailto:it-support@metrotv.com" class="btn-primary">Kirim Email</a>
      <button class="btn-outline" data-close>Tutup</button>
    </div>
  </div>
</div>

{{-- ====== MODAL: Panduan Lengkap ====== --}}
<div id="mdGuide" class="hc-modal" role="dialog" aria-modal="true" aria-labelledby="mdGuideTitle" hidden>
  <div class="hc-panel">
    <div class="hc-panel-head">
      <h3 id="mdGuideTitle">Panduan Lengkap Penggunaan</h3>
      <button class="hc-close" data-close>×</button>
    </div>
    <div class="hc-panel-body">
      <h4>1. Master Data</h4>
      <ul class="hc-bullets">
        <li><b>Master Item</b> → tambah item, unit, dan rentang harga.</li>
        <li><b>Master Program</b> → buat program + pilih PIC.</li>
        <li><b>Master Template</b> → susun template dari item, atur QTY.</li>
      </ul>
      <h4>2. Buat Budget</h4>
      <ul class="hc-bullets">
        <li>Pilih template, isi nama budget, departemen, periode, deskripsi.</li>
        <li>Setelah tersimpan, item dari template muncul otomatis.</li>
      </ul>
      <h4>3. Approval</h4>
      <ul class="hc-bullets">
        <li>Manager/atasan menilai: <i>Approve</i>, <i>Send Back</i>, atau <i>Reject</i>.</li>
        <li>Status tampil di Dashboard dan Approval Budget.</li>
      </ul>
    </div>
    <div class="hc-panel-foot">
      <button class="btn-outline" data-close>Tutup</button>
    </div>
  </div>
</div>

{{-- ====== MODAL: FAQ ====== --}}
<div id="mdFaq" class="hc-modal" role="dialog" aria-modal="true" aria-labelledby="mdFaqTitle" hidden>
  <div class="hc-panel">
    <div class="hc-panel-head">
      <h3 id="mdFaqTitle">FAQ</h3>
      <button class="hc-close" data-close>×</button>
    </div>
    <div class="hc-panel-body">
      <div class="hc-faq">
        <details>
          <summary>Kenapa saya tidak bisa menghapus template?</summary>
          <p>Template yang sudah dipakai budget tidak bisa dihapus. Hapus atau alihkan budget terkait terlebih dahulu.</p>
        </details>
        <details>
          <summary>Bagaimana mengganti PIC program?</summary>
          <p>Buka <b>Master Program</b>, klik <i>Edit</i>, pilih PIC baru, lalu simpan.</p>
        </details>
        <details>
          <summary>OTP tidak masuk ke email?</summary>
          <p>Periksa folder spam, pastikan alamat email benar, atau minta kirim ulang setelah jeda 60 detik.</p>
        </details>
      </div>
    </div>
    <div class="hc-panel-foot">
      <button class="btn-outline" data-close>Tutup</button>
    </div>
  </div>
</div>

@endsection

@push('scripts')
<script src="{{ asset('js/help-center.js') }}" defer></script>
@endpush