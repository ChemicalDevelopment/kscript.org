# This "hook" is executed right before the site's pages are rendered
Jekyll::Hooks.register :site, :pre_render do |site|
    puts "Adding kscript lexer..."
    require "rouge"

    # This class defines the PDL lexer which is used to highlight "pdl" code snippets during render-time
    class MoreKSLexer < Rouge::Lexers::Python
        title 'kscript'
        aliases 'ks', 'kscript'
    end
end

