require 'yaml'

class HourLogger

    def initialize
        puts "New hourlogger created"
    end
    
    def self.help
        print "Start new (m)onth, (l)oad existing month, (s)ave current month,
          (c)reate new project, (a)dd hours to existing project,
          (p)rint project, print all p(r)ojects, print all m(o)nths,
          (h)elp, or (q)uit? "
    end

    def self.addMonth
        done = false
        while done == false
            print "Enter month: "
            @month = gets.chomp!.downcase
            @projects = []
            if @month.length > 0
                done = true
            end
        end
    end

    def self.addProject
        if @month
            done = false
            while done == false
                print "Enter project name: "
                projName = gets.chomp!.downcase
                if projName.length > 0
                    done = true
                end
            end
            @projects << [projName, 0] unless @projects.assoc(projName)
        else
            puts "Need to load a month first"
        end
    end

    def self.addHours
        if @month.nil?
            puts "Need to load a month first"
            return
        elsif @projects.length == 0
            puts "No projects to add to"
            return
        end

        print "Enter project name: "
        name = gets.chomp!.downcase
        if @projects.assoc(name).nil?
            raise NameError
        end
        print "Enter hours: "
        hours = gets.to_f
        @projects.assoc(name)[1] += hours
    rescue NameError
        puts "No such project"
        retry
    end

    def self.printProject
        if @month.nil?
            puts "Need to load a month first"
            return
        end
        print "Enter project name: "
        projName = gets.chomp!.downcase
        if @projects.assoc(projName).nil?
            raise nameError
        end
        proj = @projects.assoc(projName)
        puts @month + ":"
        puts proj[0] + ": " + proj[1].to_s + " hours"
    rescue NameError
        puts "No such project"
        retry
    end

    def self.printAllProjects
        if @month.nil?
            puts "Need to load a month first"
            return
        end
        puts @month + ":"
        if @projects.length == 0
            puts "No projects in this month"
        end
        @projects.each {|proj| puts proj[0] + ": " + proj[1].to_s + " hours"}
    end

    def self.printAllMonths
        Dir["*.yaml"].each {|month| puts month[0..-5]}
    end

    def self.save
        if @month
            file = File.new(@month.downcase + ".yaml", "w")
            YAML.dump(@projects, file)
            file.close
            puts @month + " saved"
        else
            puts "Need to load a month first"
        end
    end

    def self.read
        begin
            print "Enter month to load: "
            month = gets.chomp!.downcase
            file = File.open(month + ".yaml")
            @projects = YAML.load(file)
            @month = month
            puts month + " loaded"
        rescue
            puts "No such month"
            retry
        end
    end

    if __FILE__ == $0
        # Display help first time
        help

        # Main loop
        @quit = false
        until @quit
    
            puts
            print "? "        
            input = gets.chomp!.downcase
            case input
                when "m" then addMonth
                when "l" then read
                when "s" then save
                when "c" then addProject
                when "a" then addHours
                when "p" then printProject
                when "r" then printAllProjects
                when "o" then printAllMonths
                when "h" then help
                when "q" then @quit = true
                else puts "Invalid input"
            end
        end
    end
end

