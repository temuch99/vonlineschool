# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_21_190200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "homework_answers", force: :cascade do |t|
    t.string "answer"
    t.bigint "homework_attempt_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["homework_attempt_id"], name: "index_homework_answers_on_homework_attempt_id"
  end

  create_table "homework_attempts", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "user_id", null: false
    t.integer "result", default: 0
    t.boolean "checked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_homework_attempts_on_lesson_id"
    t.index ["user_id"], name: "index_homework_attempts_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.string "text_lection"
    t.text "video_lection"
    t.text "lection_links"
    t.integer "survey_size", default: 5
    t.text "description"
    t.integer "survey_duration", default: 45
    t.integer "position"
    t.integer "attempts", default: 3
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "homework"
    t.datetime "survey_end_at", default: "2020-12-05 04:47:25"
    t.bigint "section_id", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["section_id"], name: "index_lessons_on_section_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "task"
    t.string "correct_answer"
    t.bigint "lesson_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "title"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.bigint "survey_attempt_id", null: false
    t.string "answer"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_survey_answers_on_question_id"
    t.index ["survey_attempt_id"], name: "index_survey_answers_on_survey_attempt_id"
  end

  create_table "survey_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "result", default: 0
    t.boolean "done", default: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "survey_end_at"
    t.index ["lesson_id"], name: "index_survey_attempts_on_lesson_id"
    t.index ["user_id"], name: "index_survey_attempts_on_user_id"
  end

  create_table "text_lections", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.string "lection"
    t.string "title"
    t.index ["lesson_id"], name: "index_text_lections_on_lesson_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.text "description"
    t.string "parent_email"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "homework_answers", "homework_attempts"
  add_foreign_key "homework_attempts", "lessons"
  add_foreign_key "homework_attempts", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "sections"
  add_foreign_key "sections", "courses"
  add_foreign_key "survey_answers", "questions"
  add_foreign_key "survey_answers", "survey_attempts"
  add_foreign_key "survey_attempts", "lessons"
  add_foreign_key "survey_attempts", "users"
  add_foreign_key "text_lections", "lessons"
  add_foreign_key "users_roles", "roles"
  add_foreign_key "users_roles", "users"
end
