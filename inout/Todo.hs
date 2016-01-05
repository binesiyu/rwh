import           Data.List
import           System.Directory
import           System.Environment
import           System.IO

dispatch :: [(String,[String] -> IO ())]
dispatch = [("add",add)
           ,("view",view)
           ,("remove",remove)
           ]

main = do
     (command:args) <- getArgs
     let (Just action) = lookup command dispatch
     action args

add :: [String] -> IO ()
add [filename,todoItem] = appendFile filename (todoItem ++ "\n")

view :: [String] -> IO ()
view [filename] = do
        contents <- readFile filename
        let todoTasks = lines contents
            numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
        putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [filename,numberString] = do
        handle <- openFile filename ReadMode
        (tempName,tempHandle) <- openTempFile "." "temp"
        contents <- hGetContents handle
        let number = read numberString
            todoTasks = lines contents
            newTodoItems = delete (todoTasks !! number) todoTasks
        hPutStr tempHandle $ unlines newTodoItems
        hClose handle
        hClose tempHandle
        removeFile filename
        renameFile tempName filename
