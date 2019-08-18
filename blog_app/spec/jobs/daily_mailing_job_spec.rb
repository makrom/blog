require 'rails_helper'

RSpec.describe DailyMailingJob, type: :job do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#perform_later" do
    it "daily mailing" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        DailyMailingJob.perform_later('user')
      }.to have_enqueued_job
    end
  end
end
