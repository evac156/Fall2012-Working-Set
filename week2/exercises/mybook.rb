class MyBook

    attr_accessor :title, :pages

    def initialize(title, pages, author)
        @title = title
        @pages = pages
        @author = author
    end

    def page_count
        "Page count is #{@pages}"
    end

    def author=(author)
        @author = author
    end

    def author
        @author
    end

    def to_s
        "\"#{@title}\" was written by #{@author} and is #{@pages} pages long."
    end
end
