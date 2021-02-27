class Dictionary {
  // Menu & Title
  static String loginScreen = 'Login Screen';
  static String testMasifCheckin = "Tes Masif Checkin";
  static String inputRegistrationCOde = "Input Nomor Pendaftaran";
  static String inputlabCode = "Input Nomor Sampel";
  static String listParticipant = 'Daftar Peserta';
  static String testMasifOffline = 'Tes Masif Checkin Offline Mode';
  static String welcomeText =
      'Selamat datang di \nAplikasi Pendaftaran Tes \nMasif';
  static String eventList = 'Daftar Kegiatan';
  static String pikobarTestMasif = 'PIKOBAR Tes Masif Checkin';

  // Button Text
  static String yes = 'Ya';
  static String no = 'Tidak';
  static String cancel = 'Cancel';
  static String close = 'Tutup';
  static String ok = 'OK';
  static String or = 'atau';
  static String login = 'Login';
  static String loginButton = 'Masuk';
  static String inputActivityCode = 'Input Kode Kegiatan';
  static String scanQR = 'Scan QR Code';
  static String inputRegistrationCode = 'Input Nomor Pendaftaran';
  static String checkListParticipant = 'Lihat Daftar Peserta';
  static String logout = 'Log Out';
  static String checkin = 'Checkin';
  static String submit = 'Submit';
  static String backToLogin = 'Kembali Ke Login';
  static String choose = 'Pilih';
  static String check = 'Lihat';
  static String send = 'Kirim';
  static String delete = 'Hapus';

// Error messages
  static String errorConnection = 'Oops! Internet Terputus';
  static String errorConnectionDesc =
      'Sepertinya internet kamu terputus, silahkan \ncek kembali koneksi internet kamu';
  static String errorIOConnection = 'Koneksi ke server bermasalah';
  static String eventExpired = 'Event Sudah Berakhir';
  static String unauthorized = 'Username/Password Tidak Sesuai';
  static String numberRegistrationNotFound =
      'Kode registrasi tidak ditemukan dalam event ini';
  static String numberRegistrationAlreadyCheckin =
      'Kode registrasi telah checkin pada ';
  static String labCodeAlreadyUsed = 'Kode lab telah digunakan oleh';
  static String alreadyCheckinMessage =
      ' Nomor Pendaftar sudah digunakan untuk checkin pada event ini.';
  static String alreadyCheckinMessageOffline = 'Kode registrasi telah checkin';
  static String exeption = 'Exception:';
  static String unauthorizedText = 'Unauthorized';
  static String tokenExpired = 'Token Expired';

  //Validation
  static String eventCodeValidation = 'Kode kegiatan harus diisi';
  static String locationValidation = 'Lokasi harus diisi';
  static String labCodeValidation = 'Kode sampel harus diisi';
  static String usernameValidation = 'Username harus diisi';
  static String passwordValidation = 'Password harus diisi';
  static String registrationCodeValidation = 'Nomor pendaftaran harus diisi';

  // Toast Messages
  static String pleaseWait = 'Tunggu Sebentar';
  static String checkinSuccess = ' berhasil checkin';
  static String checkinSuccessOffline = ' Berhasil checkin';
  static String offlineMode = 'Offline Mode';
  static String offlineModeListParticipant =
      'Data dibawah merupakan data offline';
  static String scanQRPermission =
      'Untuk scan QR Code izinkan mengakses kamera';
  static String bulkCheckinMessage = 'Data berhasil terkirim ';

  // placeholder / hint text / field text
  static String username = 'Username';
  static String usernamePlaceholder = 'Contoh: satgascovid';
  static String password = 'Katasandi';
  static String passwordPlaceholder = 'Katasandi anda';
  static String location = 'Lokasi';
  static String locationPlaceholder = 'Bandung';
  static String labCode = 'Kode Sampel';
  static String labCodePlaceholder = 'Contoh: LAB0001';
  static String registrationCode = 'Nomor Pendaftaran';
  static String registrationCodePlaceholder = 'Contoh: 32012345';
  static String activityCode = 'Kode Kegiatan';
  static String activityCodePlaceholder = 'Masukan kode kegiatan';
  static String searchListParticipant = 'Cari Daftar Peserta';
  static String searchListEvent = 'Cari Daftar Kegiatan';
  static String createdAt = 'Created At';
  static String usernameDescription = 'Masukan username yang telah terdaftar';
  static String locationDescription = 'Masukan lokasi anda';
  static String labSampleDescription =
      'Masukan nomer sampel yang telah tersedia';

  // kegiatan detail screen
  static String activityName = 'Nama Kegiatan Test : ';
  static String time = 'Waktu : ';
  static String wib = ' WIB';
  static String checkinLocation = 'Tempat Checkin : ';
  static String yourRegistrationCode = 'No Registrasi anda : ';
  static String checkinDesc =
      'Masukan kode sampel terlebih dahulu atau langsung tekan checkin';
  static String name = 'Nama Anda : ';
  static String labCodeInput = 'Kode Sample : ';
  static String warningBeforeCheckin =
      'Pastikan data sudah benar sebelum menekan tombol submit';
  static String activityCodeTitle = 'Kode Kegiatan : ';
  static String listDataCheckin = 'Lihat Data Checkin';

  // event list screen
  static String emptyDataParticipant = 'Tidak ada data daftar peserta';
  static String dataParticipantLoading = 'Sedang mengambil data ...';
  static String date = 'Tanggal: ';
  static String totalParticipant = 'Peserta: ';
  static String welome = 'Welcome!';
  static String welcomeTextEventList =
      'Selamat datang di aplikasi \nPendaftaran Tes Masif';
  static String eventDone = 'Selesai';
  static String eventOnProgress = 'Belum Selesai';
  static String people = ' Orang';
  static String infoParticipantList =
      'Ketuk detail kegiatan dibawah ini untuk melihat \ndaftar peserta';

  // daftar peserta screen
  static String present = 'Hadir';
  static String absent = 'Tidak Hadir';
  static String numberRegistration = 'Nomor Registrasi';
  static String checkinDate = 'Tanggal Checkin : ';
  static String listParticipantDescription =
      'Berikut adalah daftar peserta \ntes masif di ';
  static String pleaseSendOfflineData =
      ', harap mengirimkan data terlebih dahulu';

  // Scan QR Screen
  static String scanQrInfo =
      'Anda juga dapat melakukan checkin dengan memasukan \nnomer pendaftaran yang telah anda terima!';

// Input Sample Number Screen
  static String sampleNumberInfo =
      'Anda telah terdaftar di aplikasi pendaftaran tes masif, \nsilahkan masukan nomer sampel yang telah tersedia.';

  // offline checkin
  static String confirmDelete = 'Apakah anda yakin akan menghapus ';
}
