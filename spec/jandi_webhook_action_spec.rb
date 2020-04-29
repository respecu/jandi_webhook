describe Fastlane::Actions::JandiWebhookAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The jandi_webhook plugin is working!")

      Fastlane::Actions::JandiWebhookAction.run(nil)
    end
  end
end
