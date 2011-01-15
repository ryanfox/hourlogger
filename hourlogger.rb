class HourLogger

    def initialize
        puts "New hourlogger created"
    end
    
    def self.help
        print "Start new (m)onth, (l)oad existing month, (s)ave current month,
          (c)reate new project, add (h)ours to existing project,
          (p)rint project, print all p(r)ojects, print all m(o)nths,
          (h)elp, or (q)uit? "
    end

    def self.addMonth
        print "Enter month: "
        @month = gets.chomp!.downcase
        @projects = []
    end

    def self.addProject
        print "Enter project name: "
        projName = gets.chomp!.downcase
        @projects << [projName, 0] unless @projects.assoc(projName)
    end

    def self.addHours
        print "Enter project name: "
        name = gets.chomp!.downcase
        print "Enter hours:"
        hours = gets.to_f
        @projects.assoc(name)[1] += hours
    end

    def self.printProject
        print "Enter project name: "
        projName = gets.chomp!.downcase
        proj = @projects.assoc(projName)
        puts @month << ":"
        puts proj[0] + ": " + proj[1].to_s + " hours"
    end

    def self.printAllProjects
        puts @month <<":"
        @projects.each {|proj| puts proj[0] + ": " + proj[1].to_s + " hours"}
    end

    def self.printAllMonths
        Dir["*.bak"].each {|month| puts month}
    end

    def self.save
        marshalDump = Marshal.dump(@projects)
        file = File.new(@month.downcase << ".bak", 'w')
        file << marshalDump
        file.close
        puts @month << " saved"
    end

    def self.read
        print "Enter month to load: "
        month = gets.chomp!.downcase
        file = File.open(month << ".bak")
        @projects = Marshal.load(file)
        @month = month
        puts month << " loaded"
    end

    # Display help first time
    help

    # Main loop
    @quit = false
    until @quit
    
        print "\n"
        print "? "        
        input = gets.chomp!.downcase
        case input
            when "m" then addMonth
            when "l" then read
            when "s" then save
            when "c" then addProject
            when "h" then addHours
            when "p" then printProject
            when "r" then printAllProjects
            when "o" then printAllMonths
            when "h" then help
            when "q" then @quit = true
            else puts "Invalid input"
        end
    end

end

