from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Todo(BaseModel):
    id: int
    task: str
    completed: bool = False

todos = []

@app.post("/todos")
def create_todo(todo: Todo):
    todos.append(todo)
    return {"message": "Todo created successfully!", "todo": todo}

@app.get("/todos")
def get_todos():
    return {"todos": todos}

