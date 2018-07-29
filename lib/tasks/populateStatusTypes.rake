namespace :fillQuoteStatusTypes do
  desc 'Fill data for status table'
  task data: :environment do

    QuoteStatusType.delete_all
    # ActiveRecord::Base.connection.reset_pk_sequence!('status_types')

    @status_types = QuoteStatusType.create!(status_type_name: "pending", description: "represents a pending status")
    @status_types = QuoteStatusType.create!(status_type_name: "canceled", description: "represents a canceled status")
    @status_types = QuoteStatusType.create!(status_type_name: "approved", description: "represents an approved status")
    @status_types = QuoteStatusType.create!(status_type_name: "on hold", description: "represents an on hold status")
    @status_types = QuoteStatusType.create!(status_type_name: "more information required", description: "indicates that the quote requires more info before a decision can be made")
    @status_types = QuoteStatusType.create!(status_type_name: "in progress", description: "indicates that the quote is currently being looked at")
    @status_types = QuoteStatusType.create!(status_type_name: "completed", description: "represents the quote has been completed and can be closed")
    @status_types = QuoteStatusType.create!(status_type_name: "closed", description: "represents a closed quote")

  end
end
