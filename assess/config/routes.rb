Rails.application.routes.draw do

  root to: "assess#index"

  devise_for :instructors, path: 'instructors', controllers: {
    sessions: "instructors/sessions/sessions",
    sections: "instructors/sessions/sections",
    groups: "instructors/sessions/groups",
    confirmations: "instructors/confirmations",
    passwords: "instructors/passwords",
    registrations: "instructors/registrations",
    unlocks: "instructors/unlocks",
  }
  as :instructor do
    get 'instructors/dashboard', to: 'instructors/sessions/sessions#dashboard', as: :instructor_dashboard
    
    ## all routes for instructor classes
    get 'instructors/class/new', to: 'instructors/sessions/sections#new', as: :new_instructor_class
    post 'instructors/class/create', to: 'instructors/sessions/sections#create', as: :create_instructor_class
    get 'instructors/classes', to: 'instructors/sessions/sections#index', as: :instructor_classes
    get 'instructors/class/:id', to: 'instructors/sessions/sections#show', as: :instructor_class
    delete 'instructors/class/:id', to: 'instructors/sessions/sections#destroy'
    
    ## all routes for instructor class groups
    get 'instructors/class/:section_id/group/new', to: 'instructors/sessions/groups#new'
    post 'instructors/class/:section_id/group/create', to: 'instructors/sessions/groups#create'
    get 'instructors/class/:section_id/groups', to: 'instructors/sessions/groups#index'
    get 'instructors/class/:section_id/group/:id', to: 'instructors/sessions/groups#show'
    put 'instructors/class/:section_id/group/:id', to: 'instructors/sessions/groups#edit'
    delete 'instructors/class/:section_id/group/:id', to: 'instructors/sessions/groups#destroy'
    
    ## all routes for instructor class groups students
    get 'instructors/group/:group_id/student/add', to: 'instructors/sessions/groups#add_students'
    post 'instructors/group/:group_id/students/link', to: 'instructors/sessions/groups#link_students'
    get 'instructors/group/:group_id/students', to: 'instructors/sessions/groups#show_students'
    delete 'instructors/group/:group_id/student/:id/remove', to: 'instructors/sessions/groups#remove_student'
  
    ## instructor routes for working with peer evaluations
    get 'instructors/group/:group_id/evaluations', to: 'evaluations#index'
    get 'instructors/group/:group_id/evaluation/:id', to: 'evaluations#show'
  end
  devise_for :students, path: 'students', controllers: {
    sessions: "students/sessions",
    confirmations: "students/confirmations",
    passwords: "students/passwords",
    registrations: "students/registrations",
    unlocks: "students/unlocks",
  }
  as :student do 
    ## all routes for student
    get 'students/dashboard', to: 'students/sessions#dashboard', as: :student_dashboard
    get 'students/profile', to: 'students/sessions#profile', as: :student_profile
    
    ## student routes for looking at group
    get 'students/group/:group_id/students', to: 'students/sessions#show_students'
    
    ## student routes for peer evaluations
    get 'students/group/:group_id/evaluation/fill', to: 'evaluations#new'
    post 'students/group/:group_id/evaluation/create', to: 'evaluations#create'
    get 'students/group/:group_id/evaluations', to: 'evaluations#index'
    get 'students/group/:group_id/evaluation/:id', to: 'evaluations#show'

  end	
  

  # Redirect all unknown paths to root
  get '*unknown_path', to: redirect('/')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
