
module Redcar
  module Scm
    class ScmChangesMirror
      include Redcar::Tree::Mirror
      
      def initialize(repo)
        @repo = repo
      end
      
      def title
        @repo.translations[:uncommited_changes]
      end
      
      def data_type
        :text
      end
      
      # Root items will never change
      def changed?
        false
      end
      
      def drag_and_drop?
        false
      end
      
      def top
        @top ||= begin
          if @repo.supported_commands.include? :index
            [
              ScmChangesMirror::ChangesNode.new(@repo, :indexed),
              ScmChangesMirror::ChangesNode.new(@repo, :unindexed)
            ]
          else
            [ScmChangesMirror::ChangesNode.new(@repo, :all)]
          end
        end
      end
    end
  end
end
