require_relative '../lib/complete_me'

complete_me = CompleteMe.new

Shoes.app do
    background "#FFFFFF"
    stack(margin: 15) do
        @project_title = banner
        @project_title.text = "Complete Me - Project Visualization"
        @project_by = para
        @project_by.text = "by Nick Erhardt and Laszlo Balogh (1610BE)"
    end
    
    flow do
        
        flow(margin: 15) do
            para "Number of words loaded into dictionary: "
            word_count = complete_me.count
            @word_count_label = para
            @word_count_label.text = word_count
        end
        
        flow(margin: 15) do
            @button_full_dictionary = button "Load entire dictionary"
            @button_full_dictionary.click {
                @dictionary_status.text = "Loading..."
                dictionary = File.read("/usr/share/dict/words")
                complete_me.populate(dictionary)
                word_count = complete_me.count
                @word_count_label.text = word_count
                @suggestion_list.items = []
                if @input_box.text != ""
                    @suggestion_list.items = complete_me.suggest(@input_box.text)
                end
                @dictionary_status.text = "Loading complete."
            }
            
            @button_small_dictionary = button "Load small dictionary"
            @button_small_dictionary.click {
                @dictionary_status.text = "Loading..."
                dictionary = File.read("../test/small_dictionary.txt")
                complete_me.populate(dictionary)
                word_count = complete_me.count
                @word_count_label.text = word_count
                @suggestion_list.items = []
                if @input_box.text != ""
                    @suggestion_list.items = complete_me.suggest(@input_box.text)
                end
                @dictionary_status.text = "Loading complete."
            }
            
            @button_empty_dictionary = button "Empty dictionary"
            @button_empty_dictionary.click {
                complete_me = CompleteMe.new
                word_count = complete_me.count
                @word_count_label.text = word_count
                @suggestion_list.items = []
                if @input_box.text != ""
                    @suggestion_list.items = complete_me.suggest(@input_box.text)
                end
                @dictionary_status.text = "Emptying complete."
            }
            
            @dictionary_status = para
        end

        flow(margin: 15) do
            para "Add a word: "
            @insert_box = edit_line
            @button_insert = button "Insert word into dictionary"
            @button_insert.click {
                complete_me.insert(@insert_box.text)
                word_count = complete_me.count
                @word_count_label.text = word_count
                @insert_box.text = ""
                @suggestion_list.items = []
                if @input_box.text != ""
                    @suggestion_list.items = complete_me.suggest(@input_box.text)
                end
            }
        end

        flow(margin: 15) do
            para "Start typing: "
            @input_box = edit_line
            @input_box.change {
                @suggestion_list.items = []
                if @input_box.text != ""
                    @suggestion_list.items = complete_me.suggest(@input_box.text)
                end
            }
        end

        flow(margin: 15) do
            para "Pick a suggestion: "
            @suggestion_list = list_box
            @button_select = button "SELECT"
            @button_select.click {
                complete_me.select(@input_box.text, @suggestion_list.text)
            }
        end
        
    end

    stack(margin: 15) do
        @turing_logo = image
#            @turing_logo.height = 200
#            @turing_logo.width = 200
#            @turing_logo.path = "https://d3c5s1hmka2e2b.cloudfront.net/uploads/topic/image/182/Turing---Logo-Black.png"
        @turing_logo.path = "http://railsgirls.com/images/losangeles/turing-school.jpg"
        stack(margin: 15) do
        end
        
    end
    
end
