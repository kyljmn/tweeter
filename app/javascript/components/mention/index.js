import React, { useState } from 'react'
import PropTypes from 'prop-types'
import { MentionsInput, Mention } from 'react-mentions'

const Mention = () => {
  const [input, setInput] = useState()

  const handleChange = (event) => {
    setInput(event.target.value)
  }

  const users = ['one', 'two', 'three']

  return (
    <div>
      body here
      <MentionsInput value={input} onChange={handleChange}>
        <Mention trigger="@" data={users} />
      </MentionsInput>
    </div>
  )
}

export default Mention
