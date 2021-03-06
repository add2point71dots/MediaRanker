require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "can create a vote" do
    vote.user = User.create(username: "Yay")
    vote.work = Work.create(title: "A Movie", category: "movie")
    vote.must_be :valid?
  end

  it "a vote is required to have a user" do
    vote.valid?
    vote.errors.messages.must_include :user
  end

  it "a vote is required to have a work" do
    vote.valid?
    vote.errors.messages.must_include :work
  end

  it "a vote belongs to a user" do
    vote1 = votes(:vote1)
    vote1.user.class.must_equal User
  end

  it "a vote belongs to a work" do
    vote2 = votes(:vote2)
    vote2.work.class.must_equal Work
  end

  it "a user can't vote for the same work more than once" do
    vote.user = User.new(username: "Yay")
    vote.work = Work.new(title: "A Movie", category: "movie")
    vote.save

    new_vote = Vote.new
    vote.user = User.new(username: "Yay")
    vote.work = Work.new(title: "A Movie", category: "movie")

    new_vote.valid?.must_equal false
  end
end
