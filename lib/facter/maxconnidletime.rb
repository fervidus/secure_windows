# This fact returns the MaxConnIdleTime for DCs
require 'facter'
Facter.add('maxconnidletime') do
  confine operatingsystem: :windows
  setcode do
    if Facter.value(:windows_server_type) == 'windowsdc'
      dcDNs = Facter::Core::Execution.execute('dsquery server')
      dcDN = output.lines.first.gsub!(/\A"|"\Z/, '').split(",")
      domainDN = dcDN.last(2).join(",")
      time = Facter::Core::Execution.execute("dsquery * \"CN=Default Query Policy,CN=Query-Policies,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,#{domainDN}\" -attr LDAPAdminLimits")
      time.match(%r{MaxConnIdleTime=(\d*)})[1]
    end
  end
end
