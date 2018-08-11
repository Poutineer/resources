require("rails_helper")

RSpec.describe(Submission, :type => :model) do
  let(:actor) {create(:account)}
  let(:submission) {Submission.new(:id => "#{model.class.name}-#{model.id}", :subject => model)}

  context("when the submission is an establishment") do
    include_context("Google Places API")

    let(:model) {build(:establishment)}

    describe("#submitter") do
      subject {submission.submitter}

      before do
        PaperTrail.request(:whodunnit => actor.email, :controller_info => {:actor_id => actor.id, :context_id => SecureRandom.uuid()}) do
          model.save!
        end
      end

      it("is a AccountDecorator") do
        expect(subject).to(be_a(Account))
      end

      it("is the first contributor") do
        expect(subject).to(eq(actor))
      end
    end
  end
end
