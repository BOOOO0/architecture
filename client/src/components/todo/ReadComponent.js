import React, {useEffect, useState} from 'react';
import {getOne} from "../../api/todoApi";
import useCustomMove from "../../hooks/useCustomMove";

const initState = {
    tno: 0,
    title: '',
    content: '',
    dueDate: '',
    complete: false
}

function ReadComponent({tno}) {

    const [todo, setTodo] = useState(initState);

    // 여기에 네비게이션 커스텀 훅들을 호출해온다.
    const {moveToList, moveToModify} = useCustomMove()

    useEffect(() => {
        getOne(tno).then(data => {
            console.log(data)
            setTodo(data)
        })
    }, [tno]);

    return (
        <div className="border-2 border-sky-200 mt-10 m-2 p-4">
            {makeDiv('Tno', todo.tno)}
            {makeDiv('Title', todo.title)}
            {makeDiv('Content', todo.content)}
            {makeDiv('Complete', todo.complete ? 'Completed' : 'Not Yet')}
            {makeDiv('Writer', todo.dueDate)}

            {/* buttons.........start */}
            <div className="flex justify-end p-4">
                <button type="button"
                        className="rounded p-4 m-2 text-xl w-32 text-white bg-blue-500"
                        onClick={() => moveToList()}
                >
                    List
                </button>
                <button type="button"
                        className="rounded p-4 m-2 text-xl w-32 text-white bg-red-500"
                        onClick={() => moveToModify(todo.tno)}
                >
                    Modify
                </button>
            </div>

        </div>
    );
}

const makeDiv = (title, value) =>
    <div className=" flex justify-center">
        <div className=" relative mb-4 flex w-full flex-wrap items-stretch">
            <div className="w-1/5 p-6 text-right font-bold">{title}</div>
            <div className="w-4/5 p-6 rounded-r border border-solid shadow-md">
                {value}
            </div>
        </div>
    </div>


export default ReadComponent;