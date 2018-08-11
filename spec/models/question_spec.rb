require("rails_helper")

RSpec.describe(Question, :type => :model) do
  context("creating a record") do
    let(:model) do
      create(:question)
    end

    it("is valid") do
      expect(model).to be_valid
    end

    it("saves to the database") do
      expect(model).to be_persisted
    end
  end
end
