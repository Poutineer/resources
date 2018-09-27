require("rails_helper")

RSpec.describe(MenuItem, :type => :model) do
  xcontext("creating a record") do
    let(:model) do
      create(:menu_item)
    end

    pending("is valid") do
      expect(model).to(be_valid)
    end

    pending("saves to the database") do
      expect(model).to(be_persisted)
    end
  end
end
