Facter.add(:generated_mac) do
  setcode 'echo scutil --get ComputerName|md5|tr \'[:lower:]\' \'[:upper:]\'|sed \'s/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02\1\2\3\4\5/\''
end