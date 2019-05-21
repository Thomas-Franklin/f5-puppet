#!/opt/puppetlabs/puppet/bin/ruby
require_relative '../lib/puppet/util/task_helper'
task = Puppet::Util::TaskHelper.new('f5')

result = {}

unless Puppet.settings.global_defaults_initialized?
  Puppet.initialize_settings
end

begin
  rtn = task.transport.facts
  result[:status]  = 'success'
  result[:results] = "#{rtn}"
rescue StandardError => e
  result[:_error] = {
    msg: e.message,
    kind: 'f5devcentral/f5_puppet',
    details: {
      class: e.class.to_s,
      backtrace: e.backtrace,
    },
  }
end

puts result.to_json
