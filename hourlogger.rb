class HourLogger

    def initialize
        puts "Enter month:"
        @month = gets.chomp.downcase
        @projects = []
    end

    def addProject(projName)
        @projects << [projName.downcase, 0] unless @projects.assoc(projName)
    end

    def addHours
        puts "Enter project name:"
        name = gets.chomp.downcase
        puts "Enter hours:"
        hours = gets.to_f
        @projects.assoc(name)[1] += hours
    end

    def print(project)
        proj = @projects.assoc(project)
        puts proj[0] + ": " + proj[1].to_s + " hours"
    end

    def printAllProjects
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
        month = gets.chomp.downcase
        file = File.open(month)
        @projects = Marshal.load(file)
        @month = month
        puts month << " loaded"
    end

end

