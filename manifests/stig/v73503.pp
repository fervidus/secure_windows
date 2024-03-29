# V-73503
# Source routing must be configured to the highest protection level to prevent Internet Protocol (IP) source routing.
class secure_windows::stig::v73503 (
  Boolean $enforced = false,
) {
  if $enforced {
    # This policy setting requires the installation of the MSS-Legacy
    # custom templates included with the STIG package.
    # "MSS-Legacy.admx" and "MSS-Legacy.adml" must be copied to the
    # \Windows\PolicyDefinitions and \Windows\PolicyDefinitions\en-US directories respectively.

    include secure_windows::administrative_template_msslegacy_installer

    registry::value { 'v73503':
      key   => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters',
      value => 'EnableICMPRedirect',
      type  => 'dword',
      data  => '0x00000000',
    }
  }
}
