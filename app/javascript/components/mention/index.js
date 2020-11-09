import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import { MentionsInput, Mention } from 'react-mentions'

// const hashtags = [
//   { id: 1, display: '#hashOne' },
//   { id: 2, display: '#hashTwo' },
//   { id: 9, display: '#hashNine' },
// ]

const MentionComponent = ({ users, hashtags }) => {
  const [input, setInput] = useState()
  const [usersArray, setUsersArray] = useState([
    {
      id: '',
      display: '',
    },
  ])
  const [hashtagsArray, setHashtagsArray] = useState([
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

  const createHashtagsArray = () => {
    const hashtagsData = hashtags.map((value, index) => {
      return { id: value.id, display: value.name }
    })

    setHashtagsArray(hashtagsData)
  }

  useEffect(() => {
    createUsersArray()
    createHashtagsArray()
  }, [users, hashtags])

  return (
    <div>
      <MentionsInput
        value={input}
        onChange={handleChangeInput}
        placeholder="What's happening?"
        className="w-full flex items-center text-lg border-none py-5 mb-2"
        singleLine={true}
      >
        <Mention trigger="@" displayTransform={(username) => `@${username}`} data={usersArray} markup="@__display__" />
        <Mention trigger="#" displayTransform={(hash) => `#${hash}`} data={hashtagsArray} markup="#__display__" />
      </MentionsInput>

      <input name="twit[body]" value={input} hidden />
    </div>
  )
}

MentionComponent.propTypes = {
  Users: PropTypes.object,
}

export default MentionComponent
