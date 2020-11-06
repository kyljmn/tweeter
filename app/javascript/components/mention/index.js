import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import { MentionsInput, Mention } from 'react-mentions'

const MentionComponent = ({ users }) => {
  const [input, setInput] = useState()
  const [usersArray, setUsersArray] = useState([
    {
      id: '',
      display: '',
    },
  ])

  const handleChangeInput = (event) => {
    setInput(event.target.value)
  }

  const createUsersArray = () => {
    const usersData = users.query.map((value, index) => {
      return { id: value.id, display: value.username }
    })

    setUsersArray(usersData)
  }

  useEffect(() => {
    createUsersArray()
  }, [users])

  return (
    <div>
      <MentionsInput
        value={input}
        onChange={handleChangeInput}
        placeholder="What's happening?"
        className="w-full flex items-center text-lg border-none py-5 focus:outline-none"
      >
        <Mention trigger="@" data={usersArray} markup="@__display__" />
      </MentionsInput>

      <input name="twit[body]" value={input} hidden />
    </div>
  )
}

<<<<<<< HEAD
MentionComponent.propTypes = {
  Users: PropTypes.object,
}

export default MentionComponent
=======
export default Mention
>>>>>>> c21eb35d203be3a388574520b5651fb759edf589
