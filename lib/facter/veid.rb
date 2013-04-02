if File.exist?('/proc/self/status')
  output = %x{cat /proc/self/status|grep envID|cut -f 2}
  Facter.add('veid') do
    setcode do
      output.strip
    end
  end
end
      
