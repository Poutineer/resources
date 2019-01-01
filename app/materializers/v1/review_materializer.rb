module V1
  class ReviewMaterializer < ::V1::ApplicationMaterializer
    type(:reviews)

    has_one(:author, :class_name => "V1::AccountMaterializer")

    has(:body)
  end
end
