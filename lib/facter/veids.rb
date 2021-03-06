output = %x{which vzlist 2>&1 > /dev/null}
if $?.exitstatus == 0
  output = %x{vzlist -H -a -o veid,hostname,status}
  Facter.add('veids') do
    setcode do
      veid = []
      output.lines.each{|line|
        veid.push(line.split(' ').reject{ |e| e.empty? }.join(':'))
      }
      veid.join(' ')
    end
  end
end
