import React, { useState } from 'react'

const Register = () => {
  const [picture, setPicture] = useState(null)

  const onChangePicture = (e) => {
    setPicture(URL.createObjectURL(e.target.files[0]))
  }

  return (
    <div className={`flex ${picture && 'flex-col'} justify-between`}>
      {picture && <img src={picture} className="py-2" />}
      <div className="flex w-full justify-between">
        <label htmlFor="twit_images">
          <i className="far fa-image fa-lg fill-current text-twitter cursor-pointer" />
        </label>
        <input
          multiple={true}
          accept="image/*"
          name="commit"
          id="twit_images"
          name="twit[images][]"
          type="file"
          onChange={onChangePicture}
          className="hidden"
        />
        <input
          type="submit"
          value="Tweet"
          className="rounded-full bg-twitter text-white px-4 py-2 border-none font-bold cursor-pointer transition duration-900 ease-in-out"
        />
      </div>
    </div>
  )
}

export default Register
