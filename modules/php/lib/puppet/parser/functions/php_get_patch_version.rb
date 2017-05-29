module Puppet::Parser::Functions
  newfunction(:php_get_patch_version, :type => :rvalue) do |args|
    version = args[0]

    # Get secure version data
    Puppet::Parser::Functions.function('hiera')
    secure_versions = function_hiera( [ 'php::config::secure_versions' ] )

    # Specify secure version if no minor point specified
    if version == '5'
      patch_version = secure_versions['5.6']
    elsif version == '5.6'
      patch_version = secure_versions['5.6']
    elsif version == '5.5'
      patch_version = secure_versions['5.5']
    elsif version == '5.4'
      patch_version = secure_versions['5.4']
    else
      patch_version = version
    end

    # Warn on insecure versions
    display_secure_warning_local = args[1]
    display_secure_warning_hiera = function_hiera( [ 'php::config::secure_warning' ] )
    if display_secure_warning_local && display_secure_warning_hiera
      Puppet::Parser::Functions.function('versioncmp')
      warning = nil

      # Version is greater than or equal to 5.6.0 and less than the 5.6 secure version
      if function_versioncmp( [ patch_version, '5.6' ] ) >= 0 && function_versioncmp( [ patch_version, secure_versions['5.6'] ] ) < 0
        warning = ['5.6.X', secure_versions['5.6']]
      # Version is greater than or equal to 5.5.0 and less than the 5.5 secure version
      elsif function_versioncmp( [ patch_version, '5.5' ] ) >= 0 && function_versioncmp( [ patch_version, secure_versions['5.5'] ] ) < 0
        warning = ['5.5.X', secure_versions['5.5']]
      # Version is less than the minimum secure version
      elsif function_versioncmp( [ patch_version, secure_versions['5.4'] ] ) < 0
        warning = ['5.4.X', secure_versions['5.4']]
      end

      unless warning.nil?
        Puppet::Parser::Functions.function('warning')
        statement = 'You are installing PHP %s which is known to be insecure. The current secure %s version is %s'
        function_warning( [ sprintf( statement, patch_version, warning[0], warning[1] ) ] )
      end
    end

    return patch_version
  end
end
