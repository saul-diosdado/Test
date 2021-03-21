class PersonalitiesController < ApplicationController
  def index
    user_id = current_user.id
    @profile = Profile.find_by user_id: user_id
  end

  def myersBriggs
    #Retrieves current user’s myer’s briggs personality type
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    mbptype = @userProfile.ptmyersbriggs
    #List of good and ideal matches for first 8 personality types
    top8 = ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"]
    #List of good and ideal matches for middle 4 personality types
    middle4 = ["INTJ", "ENTJ", "INTP", "ENTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"]
    #List of good and ideal matches for bottom 4 personality types
    bottom4 = ["ISFJ", "ESFJ", "ISTJ", "ESTJ"]

    def ReturnMatches(matches)
      return Profile.where(ptmyersbriggs: matches)
    end
    #Queries profile database with list of great matches, removes ideal matches from list
    def ReturnMatchesDouble(matches1, matches2)
      matches2 -= matches1
      return Profile.where(ptmyersbriggs: matches2)
    end

    case mbptype
      when "INFP"
      idealMatches = ["ENFJ", "ENTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENFP"
      idealMatches = ["INFJ", "INTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "INFJ"
      idealMatches = ["ENFP", "ENTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENFJ"
      idealMatches = ["INFP", "ISFP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "INTJ"
      idealMatches = ["ENFP", "ENTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENTJ"
      idealMatches = ["INFP", "INTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "INTP"
      idealMatches = ["ENTJ", "ESTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENTP"
      idealMatches = ["INFJ", "INTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ISFP"
      idealMatches = ["ENFJ", "ESFJ", "ESTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ESFP"
      idealMatches = ["ISFJ", "ISTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ISTP"
      idealMatches = ["ESFJ", "ESTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ESTP"
      idealMatches = ["ISFJ", "ISTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ISFJ"
      idealMatches = ["ESFP", "ESTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      when "ESFJ"
      idealMatches = ["ISFP", "ISTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      when "ISTJ"
      idealMatches = ["ESFP", "ESTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      when "ESTJ"
      idealMatches = ["INTP", "ISFP", "ISTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      else
        redirect_to(personalities_path, {:flash => {:red => 'Profile must have MB test filled out to view this page.'}})
    end
  end

  def conflictManagement
    #Retrieves current user’s conflict management type
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    crType = @userProfile.ptanimal
    #Returns a list of users who have the same conflict animal as the user
    @sameCM = Profile.where(ptanimal: crType)
    @foxCM = nil
    if (crType != "The Compromising Fox")
      #Returns a list of users who have the fox conflict animal
      @foxCM = Profile.where(ptanimal: "The Compromising Fox")
    end
    #Depending on the user's conflict animal, returns a list of users who have the opposite type
    case crType
    when "The Compromising Fox"
      allAnimals = ["The Competitive Shark", "The Collaborative Owl", "The Avoidant Turtle", "The Accommodating Teddy Bear"]
      @oppositeMatches = Profile.where(ptanimal: Allanimals)
      @message = "As a Fox, you can match with anybody!"
    when "The Competitive Shark"
      oppositeAnimal = ["The Accommodating Teddy Bear"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = "As a Shark, your best matches are teddy bears!"
    when "The Collaborative Owl"
      oppositeAnimal = ["The Avoidant Turtle"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = "As an Owl, your best matches are turtles!!"
    when "The Avoidant Turtle"
      oppositeAnimal = ["The Collaborative Owl"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = "As a Turtle, your best matches are owls!"
    when "The Accommodating Teddy Bear"
      oppositeAnimal = ["The Competitive Shark"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
      @message = "As a Teddy Bear, your best matches are sharks!"
    else
      redirect_to(personalities_path, {:flash => {:red => 'Profile must have result of Conflict Resolution test filled out to view this page.'}})
    end
  end

  def trueColors
    #Retrieves current user’s profile
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    userTC = @userProfile.pttruecolors
    #Because there is no defined compatibility online, will just query database for users of all types, and recommend the user checks out profiles with different types
    case userTC
    when "Blue"
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @otherProfiles1 = Profile.where(pttruecolors: "Gold")
      @otherProfiles1color = "Gold"
      @otherProfiles2 = Profile.where(pttruecolors: "Green")
      @otherProfiles2color = "Green"
      @otherProfiles3 = Profile.where(pttruecolors: "Orange")
      @otherProfiles3color = "Orange"
    when "Gold"
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @otherProfiles1 = Profile.where(pttruecolors: "Blue")
      @otherProfiles1color = "Blue"
      @otherProfiles2 = Profile.where(pttruecolors: "Green")
      @otherProfiles2color = "Green"
      @otherProfiles3 = Profile.where(pttruecolors: "Orange")
      @otherProfiles3color = "Orange"
    when "Green"
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @otherProfiles1 = Profile.where(pttruecolors: "Blue")
      @otherProfiles1color = "Blue"
      @otherProfiles2 = Profile.where(pttruecolors: "Gold")
      @otherProfiles2color = "Gold"
      @otherProfiles3 = Profile.where(pttruecolors: "Orange")
      @otherProfiles3color = "Orange"
    when "Orange"
      @sameProfiles = Profile.where(pttruecolors: userTC)
      @otherProfiles1 = Profile.where(pttruecolors: "Gold")
      @otherProfiles1color = "Gold"
      @otherProfiles2 = Profile.where(pttruecolors: "Green")
      @otherProfiles2color = "Green"
      @otherProfiles3 = Profile.where(pttruecolors: "Blue")
      @otherProfiles3color = "Blue"
    else 
      redirect_to(personalities_path, {:flash => {:red => 'Profile must have result of True Colors test filled out to view this page.'}})
    end
  end

  def enneagram
    #Retrieves current user's profile
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    #As enneagram test has a list of ideal matches, will be returning a list of the profiles that have the ideal personality type for the user
    userEnneagram = @userProfile.enneagram
    case userEnneagram
    when "Reformer"
      #Type 1
      #Ideal matches are types 4 and 7
      bestTypes = ["Individualist", "Enthusiast"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Helper"
      #Type 2
      #Ideal Matches are types 4 and 8
      bestTypes = ["Individualist", "Challenger"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Achiever"
      #Type 3
      #Ideal Matches are types 6 and 9
      bestTypes = ["Loyalist", "Peacemaker"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Individualist"
      #Type 4
      #Ideal Matches are types 1 and 2
      bestTypes = ["Reformer", "Helper"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Investigator"
      #Type 5
      #Ideal Matches are types 7 and 8
      bestTypes = ["Enthusiast", "Challenger"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Loyalist"
      #Type 6
      #Ideal Matches are types 3 and 9
      bestTypes = ["Achiever", "Peacemaker"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Enthusiast"
      #Type 7
      #Ideal Matches are types 1 and 5
      bestTypes = ["Reformer", "Investigator"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Challenger"
      #Type 8
      #Ideal Matches are types 2 and 5
      bestTypes = ["Helper", "Investigator"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    when "Peacemaker"
      #Type 9
      #Ideal Matches are types 3 and 6
      bestTypes = ["Achiever", "Loyalist"]
      @bestMatches = Profile.where(enneagram: bestTypes)
    else
      redirect_to(personalities_path, {:flash => {:red => 'Profile must have result of Enneagram test filled out to view this page.'}})
    end
  end
end
