require 'swagger_helper'

RSpec.describe 'Users', type: :request do
  path '/users/follows' do
    post 'Follow a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      description 'Creates a new follow relationship between the current user and the target user'
      
      parameter name: :follow_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string, format: 'uuid' }
        },
        required: ['user_id']
      }
      
      response '200', 'Successfully followed user' do
        schema type: :object,
               properties: {
                 id: { type: :string, format: 'uuid' },
                 follower_id: { type: :string, format: 'uuid' },
                 following_id: { type: :string, format: 'uuid' },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
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
  
      response '400', 'Invalid request' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        run_test!
      end

    end
  end

  path '/users/unfollows' do
    delete 'Unfollow a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      description 'Removes a follow relationship between the current user and the target user'
      
      parameter name: :unfollow_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string, format: 'uuid' }
        },
        required: ['user_id']
      }
      
      response '200', 'Successfully unfollowed user' do
        schema type: :object,
               properties: {
                 id: { type: :string, format: 'uuid' },
                 follower_id: { type: :string, format: 'uuid' },
                 following_id: { type: :string, format: 'uuid' },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
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
  
      response '400', 'Invalid request' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        run_test!
      end
    end
  end

end