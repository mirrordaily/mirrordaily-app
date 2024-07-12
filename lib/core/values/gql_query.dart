class GQLQuery {
  static String getSections = '''
    query Sections {
      sections(orderBy: { order: asc }) {
          name
          color
          slug
          id
      }
    }
  ''';

  static String getArticleBySlug = '''
    query (\$slug: String!) {
      post(where: { slug: \$slug }) {
          id
          slug
          title
          subtitle
          state
          publishedDate
          publishedDateString
          updateTimeStamp
          extend_byline
          heroCaption
          style
          isMember
          og_description
          isFeatured
          isAdult
          apiDataBrief
          apiData
          trimmedApiData
          createdAt
          updatedAt
          writers(orderBy: { id: asc }) {
              id
              name
          }
          photographers(orderBy: { id: asc }) {
              id
              name
          }
          camera_man(orderBy: { id: asc }) {
              name
              id
          }
          designers(orderBy: { id: asc }) {
              id
              name
          }
          engineers(orderBy: { id: asc }) {
              id
              name
          }
          vocals(orderBy: { id: asc }) {
              id
              name
          }
          heroImage {
              id
              name
              waterMark
              topicKeywords
              resized {
                  original
                  w480
                  w800
                  w1200
                  w1600
                  w2400
              }
          }
          relateds(orderBy: { publishedDate: asc }) {
              id
              slug
              title
              subtitle
              adTrace
              css
              apiDataBrief
              apiData
              trimmedApiData
              createdAt
              updatedAt
          }
          tags(orderBy: { id: asc }) {
              id
              slug
              name
          }
          og_title
          categories(orderBy: { order: asc }) {
            id
            name
            slug
          }
          sections(orderBy: { order: asc }) {
              id
              name
              color
              slug
          }
      }
    }
  ''';
}
