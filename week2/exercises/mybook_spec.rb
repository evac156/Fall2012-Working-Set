require './mybook.rb'

describe MyBook do
    before :each do
        @book1 = MyBook.new("Harry Potter", 200, "J.K. Rowling")
        @book2 = MyBook.new("Call of Cthulhu", 595, "H.P. Lovecraft")
    end

    it "should respond to title" do
        @book1.should respond_to "title"
    end

    it "should respond to author" do
        @book1.should respond_to "author"
    end

    it "should respond to pages" do
        @book1.should respond_to "pages"
    end

    it "should return the title" do
        @book1.title.should eq "Harry Potter"
        @book2.title.should eq "Call of Cthulhu"
    end

    it "should return the page count" do
        @book1.page_count.should eq "Page count is 200"
        @book2.page_count.should eq "Page count is 595"
    end

    it "should return the author" do
        @book1.author.should eq "J.K. Rowling"
        @book2.author.should eq "H.P. Lovecraft"
    end

    it "should return a nicely formatted description" do
        @book1.to_s.should eq "\"Harry Potter\" was written by J.K. Rowling and is 200 pages long."
        @book2.to_s.should eq "\"Call of Cthulhu\" was written by H.P. Lovecraft and is 595 pages long."
    end

    it "should let us modify all the attributes" do
        @book1.title = "A Tale of Two Cities"
        @book1.author = "Charles Dickens"
        @book1.pages = 437
        @book1.to_s.should eq "\"A Tale of Two Cities\" was written by Charles Dickens and is 437 pages long."
    end
end
