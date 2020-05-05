# Questions


# 1.- How do you calculate the power of a number?
# n**x where "n" is the number and "x" is power.


# 2.- Write a ruby method that returns the even numbers from an array of float numbers. (Do not use the even ruby method)
  float_numbers_array.map(&:to_i).select{|n| n % 2 == 0}


# 3.- What are collection and member routes?
# Member routes are used when the action goes into an especific object, since his :id is required
# Collection routes are used when the action goes into more than 1 object, like index or search, so an :id is not required.


# 4.- What is polymorphism?
# Is the object's ability of taking many forms, for example a Car is also a Vehicle, 
# a Student is also a Person, an Income is a Transaction.

# This subclasses can override it's parent's behaviours.


# 5.- What is the purpose of object private methods?
# private methods are used for encapsulation purposes, to hide functionality from external 
# use so we can use them only inside the class that were defined. Basic example of this is strong params.




