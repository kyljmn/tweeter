import React from 'react'
import PropTypes from 'prop-types'
// import home from 'svg/home.svg'
// import explore from 'svg/explore.svg'
// import notifications from 'svg/notifications.svg'
// import profile from 'svg/profile.svg'

const Nav = ({ home, notifications, users, profile, signout, signin, register, currentUser }) => {
  const links = [
    { menu: 'Home', image: 'fal fa-house', url: '/' },
    { menu: 'Explore', image: 'fas fa-hashtag', url: '/' },
    { menu: 'Notifications', image: 'far fa-bell', url: notifications },
    { menu: 'Profile', image: 'far fa-user', url: profile },
  ]

  return (
    <div className="flex flex-col justify-between h-screen w-full mr-20" style={{ borderRight: '.5px solid #f5f5f5' }}>
      <div>
        <div className="py-4">
          <i className="fab fa-twitter fa-2x" style={{ color: '#1da1f2' }} />
        </div>
        {links &&
          links.map((value, index) => {
            return (
              <div className="pb-5">
                <i className={`${value.image} fa-lg mr-5`} />
                {/* <img src={value.image} alt={value.menu} /> */}
                <a href={value.url} className="font-bold text-lg">
                  {value.menu}
                </a>
              </div>
            )
          })}
      </div>
      <div className="flex py-5">
        <div className="mr-4">
          <i className="fas fa-user-circle fa-2x" />
        </div>
        <div className="flex flex-col">
          <a href={profile} className="font-bold">
            {currentUser.first_name}
          </a>
          <a href={profile} className="text-twitterGray">
            @{currentUser.first_name}
          </a>
          <a href={signout} data-method="delete">
            Sign Out
          </a>
        </div>
      </div>
    </div>
  )
}

Nav.propTypes = {
  home: PropTypes.object,
  notifications: PropTypes.object,
  users: PropTypes.object,
  profile: PropTypes.object,
  signout: PropTypes.object,
  signin: PropTypes.object,
  register: PropTypes.object,
  currentUser: PropTypes.object,
}

export default Nav
