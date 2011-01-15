class HourLogger
    
    def help
        puts "Start new (m)onth, (l)oad existing month, (s)ave current month,
              (c)reate new project, add (h)ours to existing project,
              (p)rint project, print (a)ll projects, (h)elp, or (q)uit?"
    end

    def addMonth
        puts "Enter month:"
        @month = gets.chomp!.downcase
        @projects = []
    end

    def addProject
        puts "Enter project name:"
        projName = gets.chomp!.downcase
        @projects << [projName, 0] unless @projects.assoc(projName)
    end

    def addHours
        puts "Enter project name:"
        name = gets.chomp!.downcase
        puts "Enter hours:"
        hours = gets.to_f
        @projects.assoc(name)[1] += hours
    end

    def print
        puts "Enter project name:"
        projName = gets.chomp!.downcase
        proj = @projects.assoc(projName)
        puts @month << ":"
        puts proj[0] + ": " + proj[1].to_s + " hours"
    end

    def printAllProjects
        puts @month <<":"
        @projects.each {|proj| puts proj[0] + ": " + proj[1].to_s + " hours"}
    end

    def save
        marshalDump = Marshal.dump(@projects)
        file = File.new(@month.downcase, 'w')
        file << marshalDump
        file.close
        puts @month << " saved"
    end

    def read
        puts "Enter month to load:"
        month = gets.chomp!.downcase
        file = File.open(month)
        @projects = Marshal.load(file)
        @month = month
        puts month << " loaded"
    end

    # Display help first time
    help

    # Main loop
    @quit = false
    until @quit
        
        input = gets.chomp!.downcase
        case input
            when "m" then addMonth
            when "l" then read
            when "s" then save
            when "c" then addProject
            when "h" then addHours
            when "p" then print
            when "a" then printAllProjects
            when "h" then help
            when "q" then quit = true
            else puts "Invalid input"
        end
    end

end

