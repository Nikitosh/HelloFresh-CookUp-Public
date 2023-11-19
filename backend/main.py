from flask import Flask, request
import json
from collections import Counter, defaultdict
import random
import os

# Create a Flask web server
app = Flask(__name__)

all_ingridients = set()

# Load user data from JSON file
with open('data/recipe.json', 'r') as file:
  recipes = json.load(file)
  for recipy in recipes:
    for ingridient in recipes[recipy]["ingr"]:
      all_ingridients.add(ingridient)

with open('data/skills.json', 'r') as file:
  skills = json.load(file)

user_allergies = {}
user_skills = {}
user_liked_recipes = defaultdict(set)

def get_recommendation(user_id):
  init_skills(user_id)
  dishes = get_dishes_for_user(user_id)
  dishes_stat = dict()
  user_ingirdients = defaultdict(float)

  ma = 1.
  for dish_name in user_liked_recipes[user_id]:
    for ing in recipes[dish_name]["ingr"]:
      user_ingirdients[ing] += 1.
      ma = max(ma, user_ingirdients[ing])
  for ing in user_ingirdients:
    user_ingirdients[ing] /= ma

  for dish_name in dishes:
    req_skills = 0
    dish = dishes[dish_name]
    if "skills" in dish:
      for skill_group in dish["skills"]:
        for skill in dish["skills"][skill_group]:
          req_skills += 1. - min(5., user_skills[user_id][skill_group][skill]) / 5.
    ingridients_distance = 0
    for ing in all_ingridients:
      ui = user_ingirdients[ing]
      di = 0
      if ing in dish["ingr"]:
        di = 1.
      ingridients_distance += (ui - di) ** 2
    ingridients_distance = ingridients_distance ** 0.5
    dishes_stat[dish_name] = {"skills_distance": req_skills, "ingr_distance": ingridients_distance}
  return dishes_stat
    


def get_dishes_for_user(user_id):
  if user_id not in user_allergies:
    return recipes
  result = {}
  for dish_name in recipes:
    bad = False
    for allergie in user_allergies[user_id]:
      if ("allergies" in recipes[dish_name]) and (
          allergie in recipes[dish_name]["allergies"]):
        bad = True
        break
    if not bad:
      result[dish_name] = recipes[dish_name]
  return result


# Define a route for retrieving user data by ID
@app.route('/recipes/<string:user_id>', methods=['GET'])
def get_user(user_id):
  data = get_dishes_for_user(user_id)
  rec = get_recommendation(user_id)
  for dn in rec:
    data[dn]["skills_distance"] = rec[dn]["skills_distance"]
    data[dn]["ingr_distance"] = rec[dn]["ingr_distance"]
  return data

@app.route('/recommendations/<string:user_id>', methods=['GET'])
def recommendations(user_id):
  return get_recommendation(user_id)

@app.route("/like/<string:user_id>", methods=["POST"])
def like(user_id):
  req = request.json
  dish_name = req["liked"]
  user_liked_recipes[user_id].add(dish_name)
  return {"status":"ok"}


@app.route('/allergies/<string:user_id>', methods=['POST'])
def set_allergies(user_id):
  allergies = request.json
  user_allergies[user_id] = list(allergies)
  return user_allergies[user_id]

@app.route('/allergies/<string:user_id>', methods=['GET'])
def get_allergies(user_id):
  if user_id in user_allergies:
    return user_allergies[user_id]
  return {}


def init_skills(user_id):
  if user_id not in user_skills:
    skill_set = {}
    for group in skills:
      skill_set[group] = {}
      for skill in skills[group]:
        skill_set[group][skill] = 0
    user_skills[user_id] = skill_set

@app.route('/skills/<string:user_id>', methods=['POST'])
def set_skills(user_id):
  init_skills(user_id)
  req = request.json
  for group in req:
    for skill in req[group]:
      value = req[group][skill]
      user_skills[user_id][group][skill] = value

  return user_skills[user_id]

@app.route('/update_skills/<string:user_id>', methods=['POST'])
def update_skills(user_id):
  init_skills(user_id)
  req = request.json
  for group in req:
    for skill in req[group]:
      user_skills[user_id][group][skill] += 1

  return user_skills[user_id]

@app.route('/skills/<string:user_id>', methods=['GET'])
def get_skills(user_id):
  init_skills(user_id)
  return user_skills[user_id]



# Run the Flask application
if __name__ == '__main__':
  app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
