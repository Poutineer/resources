module V1
  class AccountMaterializer < ::V1::ApplicationMaterializer
    type(:accounts)

    has_many(:reviews, :class_name => "V1::ReviewMaterializer", :visible => :readable_attribute?)

    has(:email)
    has(:name, :visible => :readable_attribute?)
    has(:username, :visible => :readable_attribute?)
    has(:created_at, :visible => :readable_attribute?)
    has(:updated_at, :visible => :readable_attribute?)
  end
end
