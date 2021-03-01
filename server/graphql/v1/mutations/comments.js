import { get } from 'lodash';

import * as common from '../../common/comment';
import { ValidationFailed } from '../../errors';

function require(args, path) {
  if (!get(args, path)) {
    throw new ValidationFailed(`${path} required`);
  }
}

async function editComment(_, { comment }, { remoteUser }) {
  require(comment, 'id');
  return common.editComment(comment, remoteUser);
}

async function deleteComment(_, { id }, { remoteUser }) {
  return common.deleteComment(id, remoteUser);
}

/**
 * Doing this so that I don't have to import the common module
 * directly where the comment mutations are used.
 */
const createComment = common.createCommentResolver;

export { createComment, deleteComment, editComment };
