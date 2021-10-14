require 'puppet/util/feature'
require 'puppet/util/package'

shield_plugin_dir = '/usr/share/elasticsearch/plugins/shield'

Puppet.features.add(:elasticsearch_shield_users_native) do
  File.exist?(shield_plugin_dir) &&
    Dir[shield_plugin_dir + '/*.jar'].map do |file|
      File.basename(file, '.jar').split('-')
    end.select do |parts|
      parts.include? 'shield'
    end.any? do |parts|
      parts.last =~ %r{^[\d.]+$} &&
        Puppet::Util::Package.versioncmp(parts.last, '2.3') >= 0
    end
end
