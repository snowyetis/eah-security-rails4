namespace :fillrequester_type do
  desc 'Fill data'
  task data: :environment do

    requester_type_record = RequesterType.new
    requester_type_record.requester_type = "Residential",
    requester_type_record.requester_code = "resdtl"

    requester_type_record.save!

    requester_type_record = RequesterType.new
    requester_type_record.requester_type = "Commercial",
    requester_type_record.requester_code = "cmmrcl"


    requester_type_record.save!

    requester_type_record = RequesterType.new
    requester_type_record.requester_type = "Custom",
    requester_type_record.requester_code = "cstm"

      requester_type_record.save
  end
end
