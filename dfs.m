function visited_matrix = dfs(BW,x,y)
    stack = [];
    visited = [];
    stack = [stack; [x,y]];
    %dummy value so it doesn't throw an error on first run.
    visited = [visited; [0 0]];
    while ~isempty(stack)
        % pop stack
         v = stack(end, :);
         stack(end,:) = [];
         if (~ismember(v, visited, 'rows'))
            visited = [visited; v];
            %for all edges, push to stack, these coordinates have to be in this specific order
            neighbors = [[x-1,y];[x+1,y];[x,y+1];[x,y-1];[x-1,y+1];[x+1,y+1];[x-1,y-1];[x+1,y-1]];
            for i = 1:8
                x = neighbors(i,1);
                y = neighbors(i,2);
                % break once it finds one
                if BW(x, y) == 1 && ~ismember([x,y], visited, 'rows')
                    stack = [stack; [x,y]];
                    break;
                end
            end
        end   
    end
    visited_matrix = visited;
end