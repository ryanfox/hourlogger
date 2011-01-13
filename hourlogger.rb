class HourLogger

    def initialize(month)
        @month = month
        @projects = []
    end

    def addProject(projName)
        @projects << [projName.downcase, 0] unless @projects.assoc(projName)
    end

    def addHours
        puts "Enter project name:"
        name = gets.downcase
        puts "Enter hours:"
        hours = gets.to_f

        @projects.assoc(name)[1] += hours.to_f
    end

    def print(project)
        proj = @projects.assoc(project)
        puts proj[0] + ": " + proj[1].to_s + " hours"
    end

    def printAllProjects
        @projects.each {|proj| puts proj[0] + ": " + proj[1] + " hours"}
    end

    def save
        marshalDump = Marshal.dump(@projects)
        file = File.new(@month, 'w')
        file << marshalDump
        file.close
    end

    def read(month)
        file = File.open(month)
        @projects = Marshal.load(file)
    end

end

