# V-73707
# User Account Control approval mode for the built-in Administrator must be enabled.
class secure_windows::stig::v73707 (
  Boolean $enforced = false,
) {
  if $enforced {
    if ($facts['windows_role'] and
    $facts['windows_role'] =~ /(^35|,35,|,35$)/) {
      registry::value { 'v73707':
        key   => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',
        value => 'FilterAdministratorToken',
        type  => 'dword',
        data  => '0x00000001',
      }
    }
  }
}
