require 'spec_helper_rspec'

describe Puppet::Type.type(:elasticsearch_user).provider(:ruby) do
  describe 'instances' do
    it 'has an instance method' do
      expect(described_class).to respond_to :instances
    end

    context 'without users' do
      before do
        expect(described_class).to receive(:command_with_path).with('list').and_return(
          'No users found'
        )
      end

      it 'returns no resources' do
        expect(described_class.instances.size).to eq(0)
      end
    end

    context 'with one user' do
      before do
        expect(described_class).to receive(:command_with_path).with('list').and_return(
          'elastic        : admin*,power_user'
        )
      end

      it 'returns one resource' do
        expect(described_class.instances[0].instance_variable_get(
                 '@property_hash'
        )).to eq(
          ensure: :present,
          name: 'elastic',
          provider: :ruby
        )
      end
    end

    context 'with multiple users' do
      before do
        expect(described_class).to receive(
          :command_with_path
        ).with('list').and_return(
          <<-EOL
            elastic        : admin*
            logstash       : user
            kibana         : kibana
          EOL
        )
      end

      it 'returns three resources' do
        expect(described_class.instances.length).to eq(3)
      end
    end
  end # of describe instances

  describe 'prefetch' do
    it 'has a prefetch method' do
      expect(described_class).to respond_to :prefetch
    end
  end
end
