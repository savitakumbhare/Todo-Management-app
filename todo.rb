require "active_record"
require "date"

class Todo < ActiveRecord::Base
  NO_DATE = " "
  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date =?", Date.today)
  end

  def self.due_later
    where("due_date >?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts overdue.map { |todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.map { |todo| todo.to_displayable_string }

    puts "\n\n"

    puts "Due Later\n"
    puts due_later.map { |todo| todo.to_displayable_string }
  end

  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def is_due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = "#{is_due_today? ? " " : due_date}"
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def is_completed?
    Todo.where(completed == true)
  end

  def self.mark_as_complete(todo_id)
    Todo.update(todo_id, :completed => true)
  end
end
