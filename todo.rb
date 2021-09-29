require "active_record"
require "date"

class Todo < ActiveRecord::Base
  def self.show_list
    
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    Todo.where("due_date < ?", Date.today).map { |todo| puts "#{todo.to_displayable_string}" }
    puts "\n\n"

    puts "Due Today\n"
    Todo.where("due_date = ?", Date.today).map { |todo| puts "#{todo.to_displayable_string}" }

    puts "\n\n"

    puts "Due Later\n"
    Todo.where("due_date > ?", Date.today).map { |todo| puts "#{todo.to_displayable_string}" }
  end

  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    "#{id}. #{display_status} #{todo_text}"
  end

  def is_completed?
    Todo.where(completed == true)
  end

  def due_today?
    due_date == Date.today
  end

  def self.mark_as_complete(todo_id)
    Todo.update(todo_id, :completed => true)
  end
end
