# This fact returns the MaxConnIdleTime for DCs
require 'facter'
Facter.add('maxconnidletime') do
  confine operatingsystem: :windows
  setcode do
    if Facter.value(:windows_server_type) == 'windowsdc'
      dcs = Facter::Core::Execution.execute('dsquery server')
      dc_dn = dcs.lines.first.gsub!(/\A"|"\Z/, '').split(',')
      domain_dn = dc_dn.last(2).join(',')
      time = Facter::Core::Execution.execute("dsquery * \"CN=Default Query Policy,CN=Query-Policies,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,#{domain_dn}\" -attr LDAPAdminLimits")
      time.match(%r{MaxConnIdleTime=(\d*)})[1]
    end
  end
end
