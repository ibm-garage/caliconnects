describe Admin::AlertsController do
  context "create" do
    let(:campaign) { create(:campaign) }
    let!(:user) { create(:user) }

    it "creates an alert" do
      alert_params = {
        campaign_id: campaign.id,
        alert: {
          description: "take shelter"
        }
      }

      expect{
        post :create, params: alert_params
      }.to change{ Alert.count }.by(1)
    end

    it "sends sms for alert to user" do
      new_sms = double

      allow(SmsService).to receive(:new).and_return(new_sms)
      allow(new_sms).to receive(:send_message)

      alert_description = "take shelter"

      alert_params = {
          campaign_id: campaign.id,
          alert: {
              description: "take shelter"
          }
      }

      post :create, params: alert_params

      expect(new_sms).to have_received(:send_message).with(user.phone, alert_description)
    end
  end
end
