require 'swagger_helper'

RSpec.describe 'Sleep Records', type: :request do

  path '/sleep_records' do
    get 'List all sleep records' do
      tags 'Sleep Records'
      produces 'application/json'
      
      response '200', 'sleep records found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string, format: 'uuid' },
                   clock_in_time: { type: :string, format: 'date-time' },
                   clock_out_time: { type: :string, format: 'date-time', nullable: true },
                   duration_in_seconds: { type: :integer, nullable: true }
                 }
               }

        # Specify test steps here
        run_test!
      end
    end
  end

  path '/sleep_records/clock_in' do
    post 'Clock in for sleep' do
      tags 'Sleep Records'
      produces 'application/json'
      
      response '201', 'Clocked in successfully' do
        schema type: :object,
               properties: {
                 id: { type: :string, format: 'uuid' },
                 user_id: { type: :string, format: 'uuid' },
                 clock_in_time: { type: :string, format: 'date-time' },
                 clock_out_time: { type: :string, format: 'date-time', nullable: true },
                 duration_in_seconds: { type: :integer, nullable: true },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               }

        run_test!
      end
      
      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/sleep_records/{id}/clock_out' do
    post 'Clock out from sleep' do
      tags 'Sleep Records'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, format: 'uuid', description: 'Sleep record ID'
      
      response '201', 'Clocked out successfully' do
        schema type: :object,
               properties: {
                 id: { type: :string, format: 'uuid' },
                 user_id: { type: :string, format: 'uuid' },
                 clock_in_time: { type: :string, format: 'date-time' },
                 clock_out_time: { type: :string, format: 'date-time' },
                 duration_in_seconds: { type: :integer },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               }

        run_test!
      end
      
      response '401', 'Unauthorized' do
        let(:id) { '47d3318b-dd40-43c1-9dd6-72329d307d77' }
        run_test!
      end
      
      response '404', 'Sleep record not found' do
        let(:id) { '00000000-0000-0000-0000-000000000000' }
        run_test!
      end
    end
  end

  path '/sleep_records/following' do
    get 'List sleep records of followed users from the last 7 days' do
      tags 'Sleep Records'
      produces 'application/json'
      description 'Returns sleep records of users that the current user follows, showing only completed records from the last 7 days, ordered by duration'
      
      response '200', 'Following users sleep records found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :string, format: 'uuid' },
                   clock_in_time: { type: :string, format: 'date-time' },
                   clock_out_time: { type: :string, format: 'date-time' },
                   duration_in_seconds: { type: :integer },
                   name: { type: :string }
                 }
               }

        run_test!
      end
      
      response '401', 'Unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        run_test!
      end
  
      response '404', 'No sleep records found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
               
        run_test!
      end
    end
  end

end
