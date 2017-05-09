require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest

  KEYS = %w(age human id name)

  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
    it "is a real working route" do
      # pets_url returns the whole url
      # pets_path returns just /pets
      get pets_url
      must_respond_with :success
    end

    it "returns json" do
      get pets_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get pets_url
      # response is what the action is returning
      # JSON has a class method 'parse' which parses the body of json and makes it into a ruby hash (this is something json does under the hood)
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the pets" do
      get pets_url

      body = JSON.parse(response.body)
      body.length.must_equal Pet.count
    end

    it "returns pets with exactly the required fields" do
      # keys = %w(age human id name)
      get pets_url
      body = JSON.parse(response.body)
      body.each do |pet|
        pet.keys.sort.must_equal KEYS #using constant instead
      end
    end
  end

  describe "show" do
    # This bit is up to you!
    it "must get a pet" do
      get pet_path(pets(:two).id)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal KEYS
    end

    it "Responds correctly when the pet is not found" do
      get pet_path( Pet.all.last.id + 1)

      body = JSON.parse(response.body)
      body["nothing"].must_equal true

      must_respond_with :not_found

      # Another way to do this test
      # body = JSON.parse(response.body)
      # body.must_equal "nothing" => true
    end

    it "When we get a pet id has the right information" do
      get pet_path(pets(:two).id)
      body = JSON.parse(response.body)

      KEYS.each do |key|
        body[key].must_equal pets(:two)[key]
      end

      # body["id"].must_equal pets(:two).id
      # body["name"].must_equal pets(:two).name
      # body["age"].must_equal pets(:two).age
      # body["human"].must_equal pets(:two).human
    end
  end

  describe "create" do
    let(:pet_data) {
      {
        name: "Jack",
        age: 7,
        human: "Captain Barbossa"
      }
    }

    # it "Creates a new pet" do
    #   assert_difference "Pet.count", 1 do
    #     post pets_url, params: { pet: pet_data }
    #     assert_response :success
    #   end
    #
    #   body = JSON.parse(response.body)
    #   body.must_be_kind_of Hash
    #   body.must_include "id"
    #
    #   # Check that the ID matches
    #   Pet.find(body["id"]).name.must_equal pet_data[:name]
    # end
    #
    # it "Returns an error for an invalid pet" do
    #   bad_data = pet_data.clone()
    #   bad_data.delete(:name)
    #   assert_no_difference "Pet.count" do
    #     post pets_url, params: { pet: bad_data }
    #     assert_response :bad_request
    #   end
    #
    #   body = JSON.parse(response.body)
    #   body.must_be_kind_of Hash
    #   body.must_include "errors"
    #   body["errors"].must_include "name"
    # end
  end
end
